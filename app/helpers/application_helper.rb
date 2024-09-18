module ApplicationHelper
    def link_to_add_fields(name, f, association)
      # Create a new object for the association
      new_object = f.object.send(association).klass.new
      # Generate the fields for the new object
      fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", f: builder)
      end
      # Generate a link with data attributes to add fields dynamically
      link_to(name, '#', class: "add_fields btn btn-secondary", data: { id: "new_#{association}", fields: fields.gsub("\n", "") })
    end

    def name_and_price(variant)
      "#{variant.name} - $#{variant.price} (Stock: #{variant.stock_quantity})"
    end
  end
  