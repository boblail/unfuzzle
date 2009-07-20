module Unfuzzle

  # = Milestone
  #
  # A representation of an Unfuddle Milestone.  Has the following attributes:
  #
  # [id] Unique identifier for this milestone
  # [name] Name of the milestone
  #
  class Milestone

    include Graft::Model

    attribute :id, :type => :integer
    attribute :project_id, :from => 'project-id', :type => :integer
    attribute :archived, :type => :boolean
    attribute :name, :from => 'title'
    attribute :created_at, :from => 'created-at', :type => :time
    attribute :updated_at, :from => 'updated-at', :type => :time
    attribute :due_on, :from => 'due-on', :type => :date

    # Return a list of all milestones for a given project
    def self.find_all_by_project_id(project_id)
      response = Request.get("/projects/#{project_id}/milestones")
      collection_from(response.body, 'milestones/milestone')
    end

    def self.find_by_project_id_and_milestone_id(project_id, milestone_id)
      response = Request.get("/projects/#{project_id}/milestones/#{milestone_id}")
      new response.body
    end

    # Has this milestone been archived?
    def archived?
      archived == true
    end

    def past?
      due_on < Date.today
    end

    # The collection of Tickets associated to this milestone
    def tickets
      Ticket.find_all_by_project_id_and_milestone_id(project_id, id)
    end

  end
end