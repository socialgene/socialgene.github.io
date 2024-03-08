```
from socialgene.neo4j.neo4j_element import Neo4jElement, Node, Relationship


class nodeA(Node):
    def __init__(self, **kwargs):
        super().__init__(
            neo4j_label="nodeA",
            description="example node A",
            property_specification={
                "uid": str,
                "parentmass": float,
            },
            **kwargs
        )


class nodeB(Node):
    def __init__(self, **kwargs):
        super().__init__(
            neo4j_label="nodeB",
            description="example node B",
            property_specification={
                "uid": str,
                "charge": int,
            },
            **kwargs
        )


class Rel(Relationship):
    def __init__(self, **kwargs):
        super().__init__(
            neo4j_label="REL",
            description="example relationship",
            start_class=nodeA,
            end_class=nodeB,
            **kwargs
        )


a = nodeA(properties={"uid": "test", "parentmass": 1.0})
b = nodeB(properties={"uid": "test", "charge": 1})

z = Rel(start=a, end=b)

```
