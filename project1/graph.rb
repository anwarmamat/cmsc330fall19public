class Graph
    attr_reader :edges
    def initialize
        clear
    end

    def clear
        @edges = {}
        nil
    end

    def addVertex(v)
        raise ArgumentError, "vertex '#{v}' already exists" if @edges.has_key? v
        @edges[v] = []
        nil
    end

    def hasVertex?(v)
        @edges.has_key? v
    end

    def vertices
        @edges.keys
    end

    def hasVertices?
        !@edges.empty?
    end

    def addEdge(from, to)
        raise ArgumentError, "from vertex '#{from}' isn't in the graph" unless @edges.has_key? from
        raise ArgumentError, "to vertex '#{to}' isn't in the graph" unless @edges.has_key? to
        raise ArgumentError, "from and to edges are equal" if from == to
        raise ArgumentError, "edge from #{from} to #{to} already exists" if @edges[from].include? to
        @edges[from].push to
        nil
    end

    def hasEdge?(from, to)
        (hasVertex? from) && (@edges[from].include? to)
    end

    def bfs(origin)
        raise ArgumentError unless @edges.has_key? origin

        q = [[origin, 0]]
        r = {}
        v = [origin]

        while not q.empty?
            curr, dist = q.shift
            r[curr] = dist
            unvisited_neighbors = @edges[curr].select{|e| not v.include? e}
            unvisited_neighbors.each{|n|
                v.push n
                q.push [n, dist + 1]
            }
        end

        r
    end
end
