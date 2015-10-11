class CreateMailerLogs < ActiveRecord::Migration
  def change
    create_table :mailer_logs do |t|
      t.string :project_name
      t.integer :issue_id
      t.string :recipient, :null => false
      t.string :subject, :null => false
      t.boolean :status, :default => true
      t.timestamp :sent_at, :null => false
    end

    add_index :mailer_logs, :issue_id
  end
end
