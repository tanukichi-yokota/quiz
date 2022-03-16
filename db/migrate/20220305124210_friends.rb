class Friends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.string :last_name
      t.string :first_name
      t.string :last_name_en
      t.string :first_name_en
      t.string :group
      t.string :caption
      t.string :job

      t.timestamps
    end
  end
end
