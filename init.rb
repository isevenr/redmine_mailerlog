Redmine::Plugin.register :mailer_log do
  name 'Mailer Log plugin'
  author 'Thanh, Nguyen Duy'
  description 'Log all output emails for Redmine'
  version '0.0.1'
  url 'http://invisiblezero.net/'
  author_url 'http://invisiblezero.net/'

  permission :mailer_log, {:finder => [:index, :show]}
  
  menu :admin_menu, :mailer_log, { :controller => 'mailer', :action => 'index' }, :caption => 'Mailer Log'
end

#monkey patches
class MailObserver
  def self.delivering_email(message)
    @recipients = message.bcc
    @subject = message.subject.to_s

    pattern = Regexp.new('#\d{1,5}')
    @issue_id = pattern.match(@subject).to_s.gsub('#', '')

    if @issue_id.to_i > 0
      @project_name = Issue.find_by_id(@issue_id).project.name
    else
      @project_name = nil
    end

    @recipients.each do |recipient|
      MailerLog.create!(:recipient => recipient, :subject => @subject, :status => true, :issue_id => @issue_id, :project_name => @project_name, :sent_at => Time.now)
    end
  end
end

ActionMailer::Base.register_interceptor(MailObserver)
