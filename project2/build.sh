#!/bin/bash

# In case you use the provided ParseJSON.java code for preprocessing the wikipedia dataset, 
# uncomment the following two commands to compile and execute your modified code in this script.
#
javac ParseJSON.java
java ParseJSON

# TASK 1A:
# Create index "task1a" with "wikipage" type using BM25Similarity 
curl -XPUT 'localhost:9200/task1a?pretty' -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 5,
    "number_of_replicas": 1,
    "index": {
      "similarity": {
        "default": {
          "type": "BM25"
        }
      }
    }
  },
  "mappings": {
    "wikipage": {
      "_all" : {"type" : "string", "analyzer" : "standard"},
      "properties": {
        "abstract": {
          "type": "string",
          "analyzer": "standard"
        },
        "sections": {
          "type": "string",
          "analyzer": "standard"
        },
        "title": {
          "type": "string",
          "analyzer": "standard"
        },
        "url": {
          "type": "string",
          "analyzer": "standard"
        },
        "clicks": {
          "type": "string",
          "analyzer": "standard"
        }
      }
    }
  }
}
'
curl -XPOST  localhost:9200/task1a/_bulk?pretty=true --data-binary @data/out.txt
curl -s -XPOST 'localhost:9200/_refresh?pretty'

# TASK 1B:
# Create index "task1b" with "wikipage" type using ClassicSimilarity (Lucene's version of TFIDF implementation)
curl -XPUT 'localhost:9200/task1b?pretty' -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 5,
    "number_of_replicas": 1, 
    "index": {
      "similarity": {
        "default": {
          "type": "classic"
        }
      }
    }
  },
  "mappings": {
    "wikipage": {
      "_all" : {"type" : "string", "analyzer" : "standard"},
      "properties": {
        "abstract": {
          "type": "string",
          "analyzer": "standard"
        },
        "sections": {
          "type": "string",
          "analyzer": "standard"
        },
        "title": {
          "type": "string",
          "analyzer": "standard"
        },
        "url": {
          "type": "string",
          "analyzer": "standard"
        },
        "clicks": {
          "type": "string",
          "analyzer": "standard"
        }
      }
    }
  }
}
'
curl -XPOST  localhost:9200/task1b/_bulk?pretty=true --data-binary @data/out.txt
curl -s -XPOST 'localhost:9200/_refresh?pretty'

# TASK 2:
# Create index "task2" with "wikipage" type using BM25Similarity with the best k1 and b values that you found
curl -XPUT 'localhost:9200/task2?pretty' -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 5,
    "number_of_replicas": 1,
    "index": {
      "similarity": {
        "default": {
          "type": "BM25",
          "k1" : 0.80,
          "b" : 0.50
        }
      }
    }
  },
  "mappings": {
    "wikipage": {
      "_all" : {"type" : "string", "analyzer" : "standard"},
      "properties": {
        "abstract": {
          "type": "string",
          "analyzer": "standard"
        },
        "sections": {
          "type": "string",
          "analyzer": "standard"
        },
        "title": {
          "type": "string",
          "analyzer": "standard"
        },
        "url": {
          "type": "string",
          "analyzer": "standard"
        },
        "clicks": {
          "type": "string",
          "analyzer": "standard"
        }
      }
    }
  }
}
'
curl -XPOST  localhost:9200/task2/_bulk?pretty=true --data-binary @data/out.txt
curl -s -XPOST 'localhost:9200/_refresh?pretty'

# Task 3:
# Create index "task3" with "wikipage"
curl -XPUT 'localhost:9200/task3b?pretty' -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 5,
    "number_of_replicas": 1,
    "index": {
      "similarity": {
        "default": {
          "type": "cs246-similarity"
        }
      }
    }
  },
  "mappings": {
    "wikipage": {
      "_all" : {"type" : "text", "analyzer" : "standard"},
      "properties": {
        "abstract": {
          "type": "text",
          "analyzer": "standard"
        },
        "sections": {
          "type": "text",
          "analyzer": "standard"
        },
        "title": {
          "type": "text",
          "analyzer": "standard"
        },
        "url": {
          "type": "text",
          "analyzer": "standard"
        },
        "clicks": {
          "type": "long",
          "doc_values": true
        }
      }
    }
  }
}
'
curl -XPOST  localhost:9200/task3b/_bulk?pretty=true --data-binary @data/out.txt
curl -s -XPOST 'localhost:9200/_refresh?pretty'