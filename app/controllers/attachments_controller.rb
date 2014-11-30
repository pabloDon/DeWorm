class AttachmentsController < ApplicationController
  before_filter :require_user
  
  def create
    @attach = Attachment.new( attach: params[:attach], bug_id: params[:bug_id] )
    respond_to do |format|
      if @attach.save
        BugHistoric.create(bug_id: params[:bug_id], ref: BugHistoric.ATTACHED, user_id: current_user.id)
        format.html { redirect_to :back, notice: 'Attached!' }
      else
      end
    end
  end
end