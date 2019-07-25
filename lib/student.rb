class Student

attr_accessor :id, :name, :grade

  def initialize(id=nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS student (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
        )
        SQL
    DB[:conn].execute(sql) 
  end
  
  def self.drop_table
    sql =  <<-SQL 
      DROPS TABLE student
        SQL
    DB[:conn].execute(sql) 
  end
  
  def save
    sql = <<-SQL
      INSERT INTO student (name, grade) 
      VALUES (?, ?)
    SQL
 
    DB[:conn].execute(sql, self.name, self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
 
   def self.create(name:, grade:)
    student = Students.new(name, grade)
    student.save
    student
  end
end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
