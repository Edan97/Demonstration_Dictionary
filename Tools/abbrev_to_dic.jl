# A Julia script to convert abbreviated dictionary description to full dictionary

using Dates

"""
    transform(filename)

Output cif dictionary given a simple shorthand version
"""
transform(filename) = begin

    current_def = nothing
    is_set = false
    doing_cat = false
    current_cat = nothing
    dic_name = "UNKNOWN"
    head_name = "XXXXX"
    for line in eachline(filename)
        if length(strip(line)) == 0   # blank line ends definition
            if !isnothing(current_def)
                finish_definition(doing_cat, is_set)
                current_def = nothing
            end
            continue
        end
        
        line_start = line[begin:begin+1]
        if line_start == "# " continue end # comment
        line_rest = line[begin+2:end]
        if line_start == "#C"
            current_cat = start_category(line_rest, head_name)
            current_def = current_cat
            doing_cat = true
        end
        if line_start == "#T" add_text(line_rest) end
        if line_start == "#D"
            doing_cat = false
            current_def = start_definition(line_rest, current_cat)
        end
        if line_start == "#N" link_dataname(line_rest) end
        if line_start == "#K" write_keys(line_rest, current_cat) end
        if line_start == "#S" is_set = true end
        if line_start == "#X" dic_name = strip(line_rest) end
        if line_start == "#Z"
            head_name = top_material(dic_name, line_rest)
        end
    end
end

top_material(dic_name, dic_explanation) = begin

    head_name = dic_name[begin:begin+6]
    
    println("#\\#CIF_2.0")
    println("##################################################################")
    println("#                                                                #")
    println("#                Demonstration dictionary                        #")
    println("#                                                                #")
    println("##################################################################")
    println()
    println("data_$dic_name")
    println("  _dictionary.title           $dic_name")
    println("  _dictionary.class           Reference")
    println("  _dictionary.version         0.1.0")
    println("  _dictionary.date            $(today())")
    println("  _dictionary.ddl_conformance 4.2.0")
    println("  _dictionary.namespace       CifCore")
    println("  _description.text\n;")
    println(dic_explanation)
    println(";\n")
    println("save_$head_name")
    println("  _definition.id        $(uppercase(head_name))")
    println("  _definition.scope     Category")
    println("  _definition.class     Head")
    println("  _description.text")
    println(";\n    Topmost category for the $dic_name dictionary\n;\n")
    println("  _name.category_id     $dic_name")
    println("  _name.object_id       $(uppercase(head_name))")
    println("save_\n")

    return head_name
end

start_category(line_conts, head_cat) = begin
    catname = strip(line_conts)
    println("save_$catname")
    println("  _definition.id       $(uppercase(catname))")
    println("  _definition.scope    Category")
    println("  _definition.update   $(today())")
    println("  _name.object_id      $catname")
    println("  _name.category_id    $(uppercase(head_cat))")
    return catname
end

add_text(line_conts) = begin
    println("  _description.text")
    println(";\n$line_conts\n;")
end

write_keys(line_conts, cat_name) = begin

    cat_keys = strip.(split(line_conts,','))
    println("  loop_")
    println("    _category_key.name")
    for c in cat_keys
        println("      '_$cat_name.$c'")
    end
    
end

link_dataname(line_conts) = begin
    println("  _name.linked_item_id    '$(strip(line_conts))'")
end

start_definition(line_conts, cat_name) = begin
    objid = strip(line_conts)
    defname = "_$cat_name.$objid"
    println("save$defname")
    println("  _definition.id       '$defname'")
    println("  _definition.update   $(today())")
    println("  _name.category_id    $cat_name")
    println("  _name.object_id      $objid")
    println("  _type.contents       Text")
    println("  _type.container      Single")
    return defname
end

finish_definition(was_cat, is_set) = begin
    if was_cat
        if is_set
            println("  _definition.class     Set")
        else
            println("  _definition.class     Loop")
        end
    end
    println("save_\n")
end

if abspath(PROGRAM_FILE) == @__FILE__
    filename = ARGS[1]
    transform(open(filename))
end
