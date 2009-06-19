require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class TicketTest < Test::Unit::TestCase

    context "The Ticket class" do

      should "be able to return a list of tickets for a project" do
        project_id = 1

        response = mock_request_cycle :for => "/projects/#{project_id}/tickets", :data => 'tickets'

        tickets = []

        response.data.each do |data|
          ticket = stub()
          Ticket.expects(:new).with(data).returns(ticket)
          tickets << ticket
        end

        Ticket.find_all_by_project_id(project_id).should == tickets
      end

      should "be able to return a list of tickets for a milestone" do
        milestone_id = 1
        project_id   = 1

        response = mock_request_cycle :for => "/projects/#{project_id}/milestones/#{milestone_id}/tickets", :data => 'tickets'

        tickets = []

        response.data.each do |data|
          ticket = stub()
          Ticket.expects(:new).with(data).returns(ticket)
          tickets << ticket
        end

        Ticket.find_all_by_project_id_and_milestone_id(project_id, milestone_id).should == tickets
      end

    end

    context "An instance of the Ticket class" do

      when_populating Ticket, :from => 'tickets' do

        value_for :id,                :is => 1
        value_for :created_timestamp, :is => '2008-11-25T14:00:19Z'
        value_for :updated_timestamp, :is => '2008-12-31T15:51:41Z'
        value_for :number,            :is => 1
        value_for :title,             :is => 'Ticket #1'
        value_for :description,       :is => 'Do something important'
        value_for :due_datestamp,     :is => nil
        value_for :status,            :is => 'closed'

      end

      context "with a new instance" do
        setup { @ticket = Ticket.new(stub()) }

        should "have a create date/time" do
          DateTime.expects(:parse).with('2008-07-28T16:57:10Z').returns('create_date')

          @ticket.stubs(:created_timestamp).with().returns('2008-07-28T16:57:10Z')
          @ticket.created_at.should == 'create_date'
        end

        should "have an update date/time" do
          DateTime.expects(:parse).with('2009-04-28T18:48:52Z').returns('update_date')

          @ticket.stubs(:updated_timestamp).with().returns('2009-04-28T18:48:52Z')
          @ticket.updated_at.should == 'update_date'
        end

        should "have a due date" do
          Date.expects(:parse).with('2008-07-30').returns('due_date')

          @ticket.stubs(:due_datestamp).with().returns('2008-07-30')
          @ticket.due_on.should == 'due_date'
        end

        should "not have a due date if there isn't one associated" do
          @ticket.stubs(:due_datestamp).with().returns(nil)
          @ticket.due_on.should be(nil)
        end

      end

    end

  end
end
