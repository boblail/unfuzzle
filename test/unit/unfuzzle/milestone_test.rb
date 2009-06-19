require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class MilestoneTest < Test::Unit::TestCase

    context "The Milestone class" do

      should "be able to find all by project ID" do
        project_id = 1

        response = mock_request_cycle :for => "/projects/#{project_id}/milestones", :data => 'milestones'

        milestones = Array.new

        response.data.each do |data|
          milestone = stub()
          Unfuzzle::Milestone.expects(:new).with(data).returns(milestone)
          milestones << milestone
        end

        Milestone.find_all_by_project_id(1).should == milestones
      end

    end

    context "An instance of the Milestone class" do

      when_populating Milestone, :from => 'milestones' do

        value_for :id,                :is => 1
        value_for :archived,          :is => false
        value_for :created_timestamp, :is => '2008-07-30T22:12:37Z'
        value_for :name,              :is => 'Milestone 1'
        value_for :due_datestamp,     :is => '2008-07-30'
        value_for :updated_timestamp, :is => '2008-12-26T22:32:03Z'

      end

      should "know that it is archived" do
        milestone = Milestone.new(stub())
        milestone.stubs(:archived).with().returns(true)

        milestone.archived?.should be(true)
      end

      should "know that it isn't archived" do
        milestone = Milestone.new(stub())
        milestone.stubs(:archived).with().returns(false)

        milestone.archived?.should be(false)
      end

      should "have a create date/time" do
        milestone = Milestone.new(stub())
        milestone.stubs(:created_timestamp).with().returns('2008-07-28T16:57:10Z')

        DateTime.expects(:parse).with('2008-07-28T16:57:10Z').returns('create_date')

        milestone.created_at.should == 'create_date'
      end

      should "have an update date/time" do
        milestone = Milestone.new(stub())
        milestone.stubs(:updated_timestamp).with().returns('2009-04-28T18:48:52Z')

        DateTime.expects(:parse).with('2009-04-28T18:48:52Z').returns('update_date')

        milestone.updated_at.should == 'update_date'
      end

      should "have a due date" do
        milestone = Milestone.new(stub())
        milestone.stubs(:due_datestamp).with().returns('2008-07-30')

        Date.expects(:parse).with('2008-07-30').returns('due_date')

        milestone.due_on.should == 'due_date'
      end

    end

  end
end
