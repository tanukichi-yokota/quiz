class QuizController < ApplicationController
   protect_from_forgery
   before_action :logged_in_friend
   
   def explanation
   end
   def friend_list
      @friends = Friend.joins(:content)
      @no_answer = params[:no_answer] if params[:no_answer].present? 
   end
   def edit
      if friend_is_present?
         @friend = Friend.find(params[:id])
      else
         @friend = Friend.new()
      end
      if content_is_present?
         @content = Content.find_by(friend_id: params[:id])
      else
         @content = Content.new()
      end
   end
   def quiz
      if friend_is_present? && content_is_present?
         @friends = [Friend.find_by(id: params[:id])]
         # 前回の対象のクイズを非出題対称にする
         preselected_contents = Content.where(selected_flag: true)
         preselected_contents.update(selected_flag: false)
         # 新しいクイズを出題対象にし、出題済みにする
         @content = Content.find_by(friend_id: params[:id])
         @content.update(selected_flag: true, done_flag: true)
      else
         redirect_to quiz_friend_list_path
      end
   end
   def input_answer
      @content = Content.find_by(selected_flag: true)
      friend_id = @content.friend_id
      @friends = Friend.all
      @friend = @friends.find_by(id: friend_id)
      @answer = Answer.new
   end
   def show_answer
      if content_is_present?
         answer = Content.find_by(friend_id: params[:id]).answer
         if params[:answer] == answer
            @result = "正解!"
         else
            @result = "残念！"
            @answer = answer.upcase
         end
      else
         redirect_to quiz_friend_list_path
      end
   end
   def show_ranking
      if Answer.all.blank?
         redirect_to quiz_friend_list_path no_answer: true
         return
      end
      # 正解数を集計
      results = Answer
      .joins(:friend)
      .group(:friend_id)
      .select('answers.friend_id, sum(answers.result) as sum, friends.full_name')
      .order(sum: "desc")
      # 3位までをまとめる
      @ranking_array = [{}, {}, {}]
      ranking = 0
      score = results.first.sum
      results.each do |result|
         if result.sum != score
            ranking += 1 
            score = result.sum
         end
         break if ranking > 2
         if @ranking_array[ranking]["#{result.sum.to_i}"]
            @ranking_array[ranking]["#{result.sum.to_i}"] += ", #{result.friend.full_name}さん"
         else
            @ranking_array[ranking]["#{result.sum.to_i}"] = "#{result.friend.full_name}さん"
         end
      end
   end
   def ajax_get_name_array
      names = Friend.joins(:content).where(contents: {done_flag: false}).pluck(:full_name)
      render json: names
   end
   def ajax_set_name_link
      friends = Friend.joins(:content).where(contents: {done_flag: false})
      selected_friend = friends.order("RAND()").first
      render json: selected_friend
   end
   def ajax_reset
      Answer.delete_all
      Content.update_all(selected_flag: false, done_flag: false)
   end
   def ajax_get_content
      hash = {}
      content = Content.find_by(selected_flag: true)
      hash[:friend_name] = Friend.find_by(id: content.friend_id).full_name
      hash[:content] = content
      render json: hash.to_json
   end
   def ajax_profile_save
      friend = Friend.find_by(id: params[:id].to_i)
      hash = {}
      if profile_params[:last_name].strip != "" && profile_params[:first_name].strip != ""
         if friend
            friend.update(profile_params)
            hash[:friend_id] = params[:id].to_i
         else
            Friend.create(profile_params)
            hash[:friend_id] = Friend.last(1).first.id
         end
         hash[:msg] = "保存しました！"
         hash[:state] = "done"
         render json: hash.to_json
      else
         hash[:msg] = "名前を入力してください！"
         hash[:state] = "fail"
         render json: hash.to_json 
      end
   end
   def ajax_content_save
      content = Content.find_by(friend_id: params[:friend_id].to_i)
      hash = {}
      # postされる全てのパラメータが入力されているときのみ保存
      if content_params.values.reject(&:empty?).length == 8
         if content
            content.update(content_params)
         else
            Content.create(content_params)
         end
         hash[:msg] = "保存しました！"
         hash[:state] = "done"
         render json: hash.to_json
      elsif content_params[:friend_id].blank?
         pp "プロフィール未作成"
         hash[:msg] = "先にプロフィールを作成してください！"
         hash[:state] = "fail"
         render json: hash.to_json 
      else
         hash[:msg] = "全ての項目を入力してください！"
         hash[:state] = "fail"
         render json: hash.to_json 
      end
   end
   def ajax_post_answer
      answer = Content.find_by(id: params[:content_id]).answer
      result_record = Answer.where(friend_id: params[:answerer_id], content_id: params[:content_id])
      if params[:ans] == answer
         if result_record.present?
            result_record.update(result: 1)
         else
            Answer.create(friend_id: params[:answerer_id], content_id: params[:content_id], result: 1)
         end
      else
         if result_record.present?
            result_record.update(result: 0)
         else
            Answer.create(friend_id: params[:answerer_id], content_id: params[:content_id], result: 0)
         end
      end   
      hash = {}
      hash[:msg] = "名前を入力してください！"
      hash[:state] = "fail"
      render json: hash.to_json
   end
   
   private
   def profile_params
      params[:full_name] = params[:last_name] + params[:first_name]
      params.permit(:id, :group, :last_name_en, :first_name_en, :full_name, :last_name, :first_name, :caption, :job, :image)
   end
   def content_params
      params.permit(:friend_id, :intro, :question, :option_a, :option_b, :option_c, :option_d, :answer)
   end
   def friend_is_present?
      params[:id].present? && Friend.find_by(id: params[:id])
   end
   def content_is_present?
      params[:id].present? && Content.find_by(friend_id: params[:id])
   end
end
