class TodosController < ApplicationController
    before_action :authenticate_user
    before_action :load_todo, :authorize_todo_access!, only: [:show, :update, :destroy]

    def index
        @todos = current_user.todos
    end

    def show; end

    def create
        @todo = @current_user.todos.create(todo_params)

        render :show
        return
    end

    def update
        @todo.update(todo_params)
        render :show
        return
    end

    def destroy
        @todo.destroy

        render :show
        return
    end

    private
    def load_todo
        @todo = Todo.find(params[:id])
    end

    def todo_params
        params.require(:todo).permit(:name)
    end
end
