class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_filter :require_user

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(description: params[:description], bug_id: params[:bug])
    @note = current_user.id
    respond_to do |format|
      if @note.save
        BugHistoric.create(bug_id: params[:bug], ref: BugHistoric.COMMENTED, user_id: current_user.id)
        format.html { redirect_to :back, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:description)
    end
end
