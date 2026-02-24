class User < ActiveRecord::Base
  def not_something thing
    where.not("blah == #{thing}")
  end
  SUBQUERY_TABLE_ALIAS = "my_table_alias".freeze

  # This is used inside a larger query by using `inner_query.to_sql`
  def inner_query
    self.class.
      select("#{SUBQUERY_TABLE_ALIAS}.*").
      from("#{table_name} AS #{SUBQUERY_TABLE_ALIAS}")
  end

  def singularize_safe_literal
    [:fees, :fair].each do |type|
      Money.new(articles.sum("calculated_#{type.to_s.singularize}_cents * quantity"))
    end
  end

  def foreign_key_thing
    assoc_reflection = reflect_on_association(:foos)
    foreign_key = assoc_reflection.foreign_key

    User.joins("INNER JOIN <complex join involving custom SQL and #{foreign_key} interpolation>")
  end

  def polymorphic_name_joins
    MediaFile.joins(
      "JOIN #{table_name}
        ON media_files.parent_type = '#{polymorphic_name}'
        AND media_files.parent_id = #{table_name}.id"
    )
  end
end
