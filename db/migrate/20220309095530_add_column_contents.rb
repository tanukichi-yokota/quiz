class AddColumnContents < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :intro, :string
    add_column :contents, :question, :string
    add_column :contents, :option_a, :string
    add_column :contents, :option_b, :string
    add_column :contents, :option_c, :string
    add_column :contents, :option_d, :string
    add_column :contents, :answer, :string
  end
end