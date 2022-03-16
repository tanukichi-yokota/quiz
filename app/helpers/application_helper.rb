module ApplicationHelper
    # 説明文作成
    def greeting_msg
        greeting = "本日は大切なお時間をいただき、ありがとうございます。<br><br><br>
                    招待させていただいた新郎・新婦の友人たちとのエピソードをクイズにしてみました。<br><br>
                    クイズを通して、私たちのことだけでなく、私たちの大切な友人のことも、<br><br>
                    皆様に知っていただけたら嬉しいです。<br><br><br>
                    ぜひお手元のQRコードを読み取って、クイズにご参加ください！<br><br>
                    正解数が最も多かった方には、豪華賞品をプレゼントいたします！<br><br>"
        greeting.html_safe
    end
    def procedure_msg
        procedure = "参加方法：<br><br>
                    1, お手元のQRコード（参加用）を読み込んでください。<br><br>
                    2, クイズが出題されたら、正解だと思う選択肢を選んで、<br>
                    　「送信」ボタンを押してください。<br><br>
                    3, クイズが終了したら、「順位を確認」ボタンを押してください。<br><br>"
        procedure.html_safe
    end
    def start_msg
        start = "スタート！！"
    end
    # セレクトボックス作成
    def group_select
        group = [["新郎友人", "新郎友人"], ["新婦友人", "新婦友人"]]
    end
    def name_select
        name_select = @friends.map do |friend|
            "<option value=" + friend.id.to_s + ">" + friend.full_name + "</option>"
        end
        name_select.join.html_safe
    end
    def answer_select
        answers = [["A", "a"], ["B", "b"],["C", "c"], ["D", "d"]]
    end
end
