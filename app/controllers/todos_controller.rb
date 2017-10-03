class TodosController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :done, :undo]

  def index
    @todos = Todo.pending
    @completed_todos = Todo.completed
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect_to todos_path, notice: "To do was successfully created."
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      redirect_to todos_path, notice: "To do was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "To do was successfully deleted."
  end

  def done
    @todo.update(done: true)
    respond_to do |format|
      format.js
    end
  end

  def undo
    @todo.update(done: false)
    respond_to do |format|
      format.js
    end
  end

  private
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:description, :done)
  end
end
