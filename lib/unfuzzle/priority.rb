module Unfuzzle
  class Priority
    
    def initialize(id)
      @id = id
    end
    
    def name
      mapping[@id]
    end
    
    private
    def mapping
      {
        5 => 'Highest',
        4 => 'High',
        3 => 'Normal',
        2 => 'Low',
        1 => 'Lowest'
      }
    end
    
  end
end