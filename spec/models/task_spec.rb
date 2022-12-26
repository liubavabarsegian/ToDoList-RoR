# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations of presence' do
    context 'title' do
      it {should validate_presence_of(:title).with_message(I18n.t(:cannot_be_blank))}
    end
    context 'user_id' do
      it 'will be falsy' do
        task = Task.create({title: "task", user_id: "nil"})
        expect(task.valid?).to eq(false)
      end
    end
  end

  describe 'changes' do
    let!(:task) {Task.create({title: "Task for tests"})}
    context 'without changes' do
      it 'will be the same' do
        expect(task.title).to eq('Task for tests')
      end
    end

    context 'with changes' do
      it 'will change title' do
        task.update_attribute(:title, "another title")
        expect(task.title).to eq( "another title")
      end
    end
  end
end
