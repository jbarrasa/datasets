call apoc.load.json("https://github.com/jbarrasa/datasets/raw/master/neto/topology-nodes.json") yield value
call apoc.create.node(value.labels, apoc.map.setKey(apoc.map.removeKey(value.props, "geoLoc"),"id", value.id)) yield node
return count(node);



call apoc.load.json("https://github.com/jbarrasa/datasets/raw/master/neto/topology-rels.json") yield value
match (from {id: value.from })
match (to {id: value.to })
with from, to, value
call apoc.create.relationship(from,value.type, value.props, to) yield rel
return count(rel);


call apoc.load.json("https://github.com/jbarrasa/datasets/raw/master/neto/topology-nodes.json") yield value
with value where value.labels = ["NE"]
match (n { id: value.id }) set n.geoLoc = point({longitude: value.props.geoLoc.x, latitude: value.props.geoLoc.y });
