require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.build(:task)
  end

  describe 'タスクの保存' do
    context "タスクが保存できる場合" do
      it "タスクが入力されている場合、タスクは保存される" do
        expect(@task).to be_valid
      end
    end

    context "タスクが保存できない場合" do
      it "タスクが空の場合、タスクは保存できない" do
        @task.title = ""
        @task.valid?
        expect(@task.errors.full_messages).to include("タスクを入力してください")
      end

      it "ユーザーが紐付いていないとタスクは保存できない" do
        @task.user = nil
        @task.valid?
        expect(@task.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
