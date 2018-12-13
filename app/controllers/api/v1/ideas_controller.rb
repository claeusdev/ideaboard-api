module Api::V1
  class IdeasController < ApplicationController
    def index
      @ideas = Idea.all.order('created_at DESC')
      render json: @ideas
    end

    def create
      @idea = Idea.create(idea_params)
      if @idea.save
        render json: @idea
      else
        render json: {errors: [@idea.errors]}
      end
    end

    def update
      @idea = Idea.find(params[:id])
      @idea.update_attributes(idea_params)
      if @idea.save
        render json: @idea, notice: "Saved successfully"
      else
        render json: {errors: [@idea.errors]}
      end
    end

    def destroy
      @idea = Idea.find(params[:id])
      if @idea.destroy
        head :no_content, status: :ok
      else
        render json: {errors: [@idea.errors]}, status: :unprocessable_entity
      end
    end

    private

    def idea_params
      params.require(:idea).permit(:title, :body)
    end
  end
end

