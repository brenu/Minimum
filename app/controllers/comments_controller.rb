class CommentsController < ApplicationController
    before_action :set_comment, only: %i[destroy]

    def create
        @comment = Comment.new(comment_params)
        @comment.post_id = params[:post_id]
        @comment.user_id = Current.user.id

        if @comment.save
            redirect_to post_path(id: params[:post_id])
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        if @comment.user_id == Current.user.id
            puts "aqui"
            @comment.destroy
            redirect_to post_path(id: @comment.post_id)
        else
            render :new, status: :forbidden
        end
    end

    private

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.expect(comment: [:message])
    end
end
