class Answers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.bigint :friend_id
      t.bigint :content_id
      t.boolean :result

      t.timestamps
    end
  end
end
