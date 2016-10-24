let maxInt = 2147483647
let minInt = -2147483648

public let GraphQLInt = try! GraphQLScalarType(
    name: "Int",
    description:
    "The `Int` scalar type represents non-fractional signed whole numeric " +
    "values. Int can represent values between -(2^31) and 2^31 - 1.",
    serialize: { try .int($0.asInt(converting: true)) } ,
    parseValue: { try .int($0.asInt(converting: true)) },
    parseLiteral: { ast in
        if let ast = ast as? IntValue, let int = Int(ast.value) {
            return .int(int)
        }
        
        return .null
    }
)

public let GraphQLFloat = try! GraphQLScalarType(
    name: "Float",
    description:
    "The `Float` scalar type represents signed double-precision fractional " +
    "values as specified by " +
    "[IEEE 754](http://en.wikipedia.org/wiki/IEEE_floating_point). ",
    serialize: { try .double($0.asDouble(converting: true)) } ,
    parseValue: { try .double($0.asDouble(converting: true)) },
    parseLiteral: { ast in
        if let ast = ast as? FloatValue, let double = Double(ast.value) {
            return .double(double)
        }

        if let ast = ast as? IntValue, let double = Double(ast.value) {
            return .double(double)
        }

        return .null
    }
)

public let GraphQLString = try! GraphQLScalarType(
    name: "String",
    description:
    "The `String` scalar type represents textual data, represented as UTF-8 " +
    "character sequences. The String type is most often used by GraphQL to " +
    "represent free-form human-readable text.",
    serialize: { try .string($0.asString(converting: true)) } ,
    parseValue: { try .string($0.asString(converting: true)) },
    parseLiteral: { ast in
        if let ast = ast as? StringValue {
            return .string(ast.value)
        }

        return .null
    }
)

public let GraphQLBoolean = try! GraphQLScalarType(
    name: "Boolean",
    description: "The `Boolean` scalar type represents `true` or `false`.",
    serialize: { try .bool($0.asBool(converting: true)) } ,
    parseValue: { try .bool($0.asBool(converting: true)) },
    parseLiteral: { ast in
        if let ast = ast as? BooleanValue {
            return .bool(ast.value)
        }

        return .null
    }
)

public let GraphQLID = try! GraphQLScalarType(
    name: "ID",
    description:
    "The `ID` scalar type represents a unique identifier, often used to " +
    "refetch an object or as key for a cache. The ID type appears in a JSON " +
    "response as a String; however, it is not intended to be human-readable. " +
    "When expected as an input type, any string (such as `\"4\"`) or integer " +
    "(such as `4`) input value will be accepted as an ID.",
    serialize: { try .string($0.asString(converting: true)) },
    parseValue: { try .string($0.asString(converting: true)) },
    parseLiteral: { ast in
        if let ast = ast as? StringValue {
            return .string(ast.value)
        }

        if let ast = ast as? IntValue {
            return .string(ast.value)
        }

        return .null
    }
)
