require File.dirname(__FILE__) + '/../../test_helper'

module Unfuzzle
  class ProjectTest < Test::Unit::TestCase
    
    context "The Project class" do
      
      should "be able to return a list of all projects" do
        response = mock_request_cycle :for => '/projects', :data => 'projects'
        
        elements = Array.new
        
        response.parse.each do |data|
          element = stub()
          Unfuzzle::Project.expects(:new).with(data).returns(element)
          elements << element
        end
        
        Project.all.should == elements
      end
      
    end
    
    context "An instance of the Project class" do
      
      when_populating Project, :from => 'projects' do
    
        value_for :id,                :is => 1
        value_for :archived,          :is => false
        value_for :slug,              :is => 'aa'
        value_for :name,              :is => 'A Client'
        value_for :description,       :is => 'A great project'
        value_for :created_timestamp, :is => '2008-07-28T16:57:10Z'
        value_for :updated_timestamp, :is => '2009-04-28T18:48:52Z'
        
      end
      
      should "know that it's archived" do
        project = Project.new(stub())
        project.stubs(:archived).with().returns(true)
        
        project.archived?.should be(true)
      end
      
      should "know that it's not archived" do
        project = Project.new(stub())
        project.stubs(:archived).with().returns(false)
        
        project.archived?.should be(false)
      end
   
      should "have a create date" do
        project = Project.new(stub())
        project.stubs(:created_timestamp).with().returns('2008-07-28T16:57:10Z')
        
        DateTime.expects(:parse).with('2008-07-28T16:57:10Z').returns('create_date')
        
        project.created_at.should == 'create_date'
      end
      
      should "have an update date" do
        project = Project.new(stub())
        project.stubs(:updated_timestamp).with().returns('2009-04-28T18:48:52Z')
        
        DateTime.expects(:parse).with('2009-04-28T18:48:52Z').returns('update_date')
        
        project.updated_at.should == 'update_date'
      end
      
      should "have a list of associated milestones" do
        id = 1
        project = Project.new(stub())
        project.stubs(:id).with().returns(id)

        Milestone.expects(:find_all_by_project_id).with(id).returns('milestones')

        project.milestones.should == 'milestones'
      end

    end
    
  end
end