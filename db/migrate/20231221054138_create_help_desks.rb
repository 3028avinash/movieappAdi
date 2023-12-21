class CreateHelpDesks < ActiveRecord::Migration[7.0]
  def change
    create_table :help_desks do |t|
      t.string :question
      t.text :answer

      t.timestamps
    end
  end
end
