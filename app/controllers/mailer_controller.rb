class MailerController < ApplicationController
  unloadable


  def index
    @logs = MailerLog.paginate(:page => params[:page], :per_page => 30)
  end

  def delete_all_mail_logs
    MailerLog.destroy_all

    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Log content deleted!' }
    end
  end
end
