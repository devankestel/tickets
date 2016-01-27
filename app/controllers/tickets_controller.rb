class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @tickets = Ticket.all.recent  
  end
  def assigned
    @tickets = Ticket.all.recent.assigned_to_user(current_user)
    render :index
  end
  def issued
    @tickets = Ticket.all.recent.issued_by_user(current_user)
    render :index
  end
  def show
    @statuses = @ticket.statuses.all.recent
  end
  def new
    @user = current_user
    @ticket = @user.tickets.new    
  end
  def create
    @user = current_user
    @ticket = @user.tickets.new(ticket_params)
    if @ticket.save
      redirect_to @ticket, notice: "Ticket created successfully."
    else
      render :new
    end
  end
  def edit
    @user = current_user
    @editing = true
    render :new  
  end
  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: "Ticket updated successfully."
    else
      render :new
    end
  end
  def destroy
    @ticket.destroy
    redirect_to tickets_path
  end

  private
  def ticket_params
    params.require(:ticket).permit(:id, :title, :body, :severity, :assignee_id)
  end
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
