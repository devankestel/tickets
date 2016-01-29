class StatusesController < ApplicationController
  before_action :authenticate_user!
  def new
    @ticket = Ticket.find(params[:ticket_id])
    @user = current_user
    @status = @ticket.statuses.new
  end
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @user = current_user
    @status = @ticket.statuses.create(status_params.merge(user_id: @user.id))
    redirect_to ticket_path(@ticket)
  end

  private
  def status_params
    params.require(:status).permit(:id, :note, :category)
  end
end
