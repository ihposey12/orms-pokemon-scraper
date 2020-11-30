class Pokemon
    attr_accessor :name, :type, :hp, :db
    attr_reader :id

    def initialize(id:, name:, type:, db:)
        @name = name
        @type = type
        @db = db
        @id = id
    end

    def self.save(name, type, db)
        sql = "INSERT INTO pokemon (name, type) VALUES (?, ?);"

        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = (?);"
        result = db.execute(sql, id)[0]
        new_pokemon = Pokemon.new(id: result[0], name: result[1], type: result[2], db: db)
    end
end
