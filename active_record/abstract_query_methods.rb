module ActiveRecord
  module AbstractQueryInstanceMethods
    def save
      raise NotImplementedError
    end
  end

  module AbstractQueryClassMethods
    def find
      raise NotImplementedError
    end
    
    def helper
      raise NotImplementedError
    end
  end
end
