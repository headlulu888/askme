class UsersController < ApplicationController
  def index
    @users = [
      User.new(
          id: 1, 
          name: 'Andrey', 
          username: 'headlulu', 
          avatar_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNEaD0VjbNSZIF0JS1yFdsShIH4igp1QCmVH65Ae3y2W5dTPeq'
        ), 
      User.new(
          id: 2, 
          name: 'Misha', 
          username: 'aristofun'
        )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Ray', 
      username: 'headlulu', 
      avatar_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNEaD0VjbNSZIF0JS1yFdsShIH4igp1QCmVH65Ae3y2W5dTPeq'
      )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'О привет!', created_at: Date.parse('17.04.2016')),
      Question.new(text: 'Как там склонятор?', created_at: Date.parse('31.05.2017'))
    ]

    @new_question = Question.new
  end
end
