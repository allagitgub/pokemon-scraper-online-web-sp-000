class Pokemon
attr_accessor :id, :name, :type, :db

    def initialize(id: , name: , type: , db: )
       @id = id
       @name = name
       @type = type
       @db = db 
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
      db.execute(sql, name, type)
      @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id_item, db)
        sql = "SELECT * FROM pokemon WHERE id = ?"
        result = db.execute(sql, id_item)[0]
        Pokemon.new(id: id_item, name: result[1], type: result[2], db: @db)
    end

end
