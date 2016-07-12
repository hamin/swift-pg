//
//  PGType.swift
//  swift-pg
//
//  Created by Haris Amin on 7/11/16.
//
//

import Foundation

public enum Kind {
    case Simple
    case ArrayInt2
    case ArrayOid
    case Pseudo
    case ArrayXml
    case ArrayJson
    case ArrayLine
    case ArrayCidr
    case ArrayCircle
    case ArrayMoney
    case ArrayBool
    case ArrayBytea
    case ArrayChar
    case ArrayName
    case ArrayInt2Vector
    case ArrayInt4
    case ArrayRegproc
    case ArrayText
    case ArrayTid
    case ArrayXid
    case ArrayCid
    case ArrayOidVector
    case ArrayBpchar
    case ArrayVarchar
    case ArrayInt8
    case ArrayPoint
    case ArrayLseg
    case ArrayPath
    case ArrayBox
    case ArrayFloat4
    case ArrayFloat8
    case ArrayAbstime
    case ArrayReltime
    case ArrayTinterval
    case ArrayPolygon
    case ArrayAclitem
    case ArrayMacaddr
    case ArrayInet
    case ArrayTimestamp
    case ArrayDate
    case ArrayTime
    case ArrayTimestampTZ
    case ArrayInterval
    case ArrayNumeric
    case ArrayCstring
    case ArrayTimetz
    case ArrayBit
    case ArrayVarbit
    case ArrayRefcursor
    case ArrayRegprocedure
    case ArrayRegoper
    case ArrayRegoperator
    case ArrayRegclass
    case ArrayRegtype
    case ArrayTxidSnapshot
    case ArrayUuid
    case ArrayPgLsn
    case ArrayTsvector
    case ArrayGtsvector
    case ArrayTsquery
    case ArrayRegconfig
    case ArrayRegdictionary
    case ArrayJsonb
    case RangeInt4
    case ArrayInt4Range
    case RangeNumeric
    case ArrayNumRange
    case RangeTimestamp
    case ArrayTsRange
    case RangeTimestampTZ
    case ArrayTstzRange
    case RangeDate
    case ArrayDateRange
    case RangeInt8
    case ArrayInt8Range
    case ArrayRegnamespace
    case ArrayRegrole
}


public enum PGType: Int {
    case Bool = 16 /// BOOL - boolean, &#39;true&#39;/&#39;false&#39;
    case Bytea = 17 /// BYTEA - variable-length string, binary values escaped
    case Char = 18  /// CHAR - single character
    case Name = 19  /// NAME - 63-byte type for storing system identifiers
    case Int8 = 20  /// INT8 - ~18 digit integer, 8-byte storage
    case Int2 = 21  /// INT2 - -32 thousand to 32 thousand, 2-byte storage
    case Int2Vector = 22  /// INT2VECTOR - array of int2, used in system tables
    case Int4 = 23  /// INT4 - -2 billion to 2 billion integer, 4-byte storage
    case Regproc = 24  /// REGPROC - registered procedure
    case Text = 25  /// TEXT - variable-length string, no limit specified
    case Oid = 26  /// OID - object identifier&#40;oid&#41;, maximum 4 billion
    case Tid = 27  /// TID - &#40;block, offset&#41;, physical location of tuple
    case Xid = 28  /// XID - transaction id
    case Cid = 29  /// CID - command identifier type, sequence in transaction id
    case OidVector = 30  /// OIDVECTOR - array of oids, used in system tables
    case PgDdlCommand = 32  /// PG_DDL_COMMAND - internal type for passing CollectedCommand
    case PgType = 71  /// PG_TYPE
    case PgAttribute = 75  /// PG_ATTRIBUTE
    case PgProc = 81  /// PG_PROC
    case PgClass = 83  /// PG_CLASS
    case Json = 114   /// JSON
    case Xml = 142   /// XML - XML content
    case XmlArray = 143   /// XML&#91;&#93;
    case PgNodeTree = 194   /// PG_NODE_TREE - string representing an internal node tree
    case JsonArray = 199   /// JSON&#91;&#93;
    case Smgr = 210   /// SMGR - storage manager
    case Point = 600   /// POINT - geometric point &#39;&#40;x, y&#41;&#39;
    case Lseg = 601   /// LSEG - geometric line segment &#39;&#40;pt1,pt2&#41;&#39;
    case Path = 602   /// PATH - geometric path &#39;&#40;pt1,...&#41;&#39;
    case Box = 603   /// BOX - geometric box &#39;&#40;lower left,upper right&#41;&#39;
    case Polygon = 604   /// POLYGON - geometric polygon &#39;&#40;pt1,...&#41;&#39;
    case Line = 628   /// LINE - geometric line
    case LineArray = 629   /// LINE&#91;&#93;
    case Cidr = 650   /// CIDR - network IP address/netmask, network address
    case CidrArray = 651   /// CIDR&#91;&#93;
    case Float4 = 700   /// FLOAT4 - single-precision floating point number, 4-byte storage
    case Float8 = 701   /// FLOAT8 - double-precision floating point number, 8-byte storage
    case Abstime = 702   /// ABSTIME - absolute, limited-range date and time &#40;Unix system time&#41;
    case Reltime = 703   /// RELTIME - relative, limited-range time interval &#40;Unix delta time&#41;
    case Tinterval = 704   /// TINTERVAL - &#40;abstime,abstime&#41;, time interval
    case Unknown = 705   /// UNKNOWN
    case Circle = 718   /// CIRCLE - geometric circle &#39;&#40;center,radius&#41;&#39;
    case CircleArray = 719   /// CIRCLE&#91;&#93;
    case Money = 790   /// MONEY - monetary amounts, &#36;d,ddd.cc
    case MoneyArray = 791   /// MONEY&#91;&#93;
    case Macaddr = 829   /// MACADDR - XX:XX:XX:XX:XX:XX, MAC address
    case Inet = 869   /// INET - IP address/netmask, host address, netmask optional
    case BoolArray = 1000   /// BOOL&#91;&#93;
    case ByteaArray = 1001   /// BYTEA&#91;&#93;
    case CharArray = 1002   /// CHAR&#91;&#93;
    case NameArray = 1003   /// NAME&#91;&#93;
    case Int2Array = 1005   /// INT2&#91;&#93;
    case Int2VectorArray = 1006   /// INT2VECTOR&#91;&#93;
    case Int4Array = 1007   /// INT4&#91;&#93;
    case RegprocArray = 1008   /// REGPROC&#91;&#93;
    case TextArray = 1009   /// TEXT&#91;&#93;
    case TidArray = 1010   /// TID&#91;&#93;
    case XidArray = 1011   /// XID&#91;&#93;
    case CidArray = 1012   /// CID&#91;&#93;
    case OidVectorArray = 1013   /// OIDVECTOR&#91;&#93;
    case BpcharArray = 1014   /// BPCHAR&#91;&#93;
    case VarcharArray = 1015   /// VARCHAR&#91;&#93;
    case Int8Array = 1016   /// INT8&#91;&#93;
    case PointArray = 1017   /// POINT&#91;&#93;
    case LsegArray = 1018   /// LSEG&#91;&#93;
    case PathArray = 1019   /// PATH&#91;&#93;
    case BoxArray = 1020   /// BOX&#91;&#93;
    case Float4Array = 1021   /// FLOAT4&#91;&#93;
    case Float8Array = 1022   /// FLOAT8&#91;&#93;
    case AbstimeArray = 1023   /// ABSTIME&#91;&#93;
    case ReltimeArray = 1024   /// RELTIME&#91;&#93;
    case TintervalArray = 1025   /// TINTERVAL&#91;&#93;
    case PolygonArray = 1027   /// POLYGON&#91;&#93;
    case OidArray = 1028   /// OID&#91;&#93;
    case Aclitem = 1033   /// ACLITEM - access control list
    case AclitemArray = 1034   /// ACLITEM&#91;&#93;
    case MacaddrArray = 1040   /// MACADDR&#91;&#93;
    case InetArray = 1041   /// INET&#91;&#93;
    case Bpchar = 1042   /// BPCHAR - char&#40;length&#41;, blank-padded string, fixed storage length
    case Varchar = 1043   /// VARCHAR - varchar&#40;length&#41;, non-blank-padded string, variable storage length
    case Date = 1082   /// DATE - date
    case Time = 1083   /// TIME - time of day
    case Timestamp = 1114   /// TIMESTAMP - date and time
    case TimestampArray = 1115   /// TIMESTAMP&#91;&#93;
    case DateArray = 1182   /// DATE&#91;&#93;
    case TimeArray = 1183   /// TIME&#91;&#93;
    case TimestampTZ = 1184   /// TIMESTAMPTZ - date and time with time zone
    case TimestampTZArray = 1185   /// TIMESTAMPTZ&#91;&#93;
    case Interval = 1186   /// INTERVAL - &#64; &lt;number&gt; &lt;units&gt;, time interval
    case IntervalArray = 1187   /// INTERVAL&#91;&#93;
    case NumericArray = 1231   /// NUMERIC&#91;&#93;
    case CstringArray = 1263   /// CSTRING&#91;&#93;
    case Timetz = 1266   /// TIMETZ - time of day with time zone
    case TimetzArray = 1270   /// TIMETZ&#91;&#93;
    case Bit = 1560   /// BIT - fixed-length bit string
    case BitArray = 1561   /// BIT&#91;&#93;
    case Varbit = 1562   /// VARBIT - variable-length bit string
    case VarbitArray = 1563   /// VARBIT&#91;&#93;
    case Numeric = 1700   /// NUMERIC - numeric&#40;precision, decimal&#41;, arbitrary precision number
    case Refcursor = 1790   /// REFCURSOR - reference to cursor &#40;portal name&#41;
    case RefcursorArray = 2201   /// REFCURSOR&#91;&#93;
    case Regprocedure = 2202   /// REGPROCEDURE - registered procedure &#40;with args&#41;
    case Regoper = 2203   /// REGOPER - registered operator
    case Regoperator = 2204   /// REGOPERATOR - registered operator &#40;with args&#41;
    case Regclass = 2205   /// REGCLASS - registered class
    case Regtype = 2206   /// REGTYPE - registered type
    case RegprocedureArray = 2207   /// REGPROCEDURE&#91;&#93;
    case RegoperArray = 2208   /// REGOPER&#91;&#93;
    case RegoperatorArray = 2209   /// REGOPERATOR&#91;&#93;
    case RegclassArray = 2210   /// REGCLASS&#91;&#93;
    case RegtypeArray = 2211   /// REGTYPE&#91;&#93;
    case Record = 2249   /// RECORD
    case Cstring = 2275   /// CSTRING
    case Any = 2276   /// ANY
    case AnyArray = 2277   /// ANYARRAY
    case Void = 2278   /// VOID
    case Trigger = 2279   /// TRIGGER
    case LanguageHandler = 2280   /// LANGUAGE_HANDLER
    case Internal = 2281   /// INTERNAL
    case Opaque = 2282   /// OPAQUE
    case Anyelement = 2283   /// ANYELEMENT
    case RecordArray = 2287   /// RECORD&#91;&#93;
    case Anynonarray = 2776   /// ANYNONARRAY
    case TxidSnapshotArray = 2949   /// TXID_SNAPSHOT&#91;&#93;
    case Uuid = 2950   /// UUID - UUID datatype
    case UuidArray = 2951   /// UUID&#91;&#93;
    case TxidSnapshot = 2970   /// TXID_SNAPSHOT - txid snapshot
    case FdwHandler = 3115   /// FDW_HANDLER
    case PgLsn = 3220   /// PG_LSN - PostgreSQL LSN datatype
    case PgLsnArray = 3221   /// PG_LSN&#91;&#93;
    case TsmHandler = 3310   /// TSM_HANDLER
    case Anyenum = 3500   /// ANYENUM
    case Tsvector = 3614   /// TSVECTOR - text representation for text search
    case Tsquery = 3615   /// TSQUERY - query representation for text search
    case Gtsvector = 3642   /// GTSVECTOR - GiST index internal text representation for text search
    case TsvectorArray = 3643   /// TSVECTOR&#91;&#93;
    case GtsvectorArray = 3644   /// GTSVECTOR&#91;&#93;
    case TsqueryArray = 3645   /// TSQUERY&#91;&#93;
    case Regconfig = 3734   /// REGCONFIG - registered text search configuration
    case RegconfigArray = 3735   /// REGCONFIG&#91;&#93;
    case Regdictionary = 3769   /// REGDICTIONARY - registered text search dictionary
    case RegdictionaryArray = 3770   /// REGDICTIONARY&#91;&#93;
    case Jsonb = 3802   /// JSONB - Binary JSON
    case JsonbArray = 3807   /// JSONB&#91;&#93;
    case Anyrange = 3831   /// ANYRANGE
    case EventTrigger = 3838   /// EVENT_TRIGGER
    case Int4Range = 3904   /// INT4RANGE - range of integers
    case Int4RangeArray = 3905   /// INT4RANGE&#91;&#93;
    case NumRange = 3906   /// NUMRANGE - range of numerics
    case NumRangeArray = 3907   /// NUMRANGE&#91;&#93;
    case TsRange = 3908   /// TSRANGE - range of timestamps without time zone
    case TsRangeArray = 3909   /// TSRANGE&#91;&#93;
    case TstzRange = 3910   /// TSTZRANGE - range of timestamps with time zone
    case TstzRangeArray = 3911   /// TSTZRANGE&#91;&#93;
    case DateRange = 3912   /// DATERANGE - range of dates
    case DateRangeArray = 3913   /// DATERANGE&#91;&#93;
    case Int8Range = 3926   /// INT8RANGE - range of bigints
    case Int8RangeArray = 3927   /// INT8RANGE&#91;&#93;
    case Regnamespace = 4089   /// REGNAMESPACE - registered namespace
    case RegnamespaceArray = 4090   /// REGNAMESPACE&#91;&#93;
    case Regrole = 4096   /// REGROLE - registered role
    case RegroleArray = 4097   /// REGROLE&#91;&#93;
    // Other(Other) =  /// An unknown type.

    func name() -> String {
        switch self {
        case .Bool: return "bool"
        case .Bytea: return "bytea"
        case .Char: return "char"
        case .Name: return "name"
        case .Int8: return "int8"
        case .Int2: return "int2"
        case .Int2Vector: return "int2vector"
        case .Int4: return "int4"
        case .Regproc: return "regproc"
        case .Text: return "text"
        case .Oid: return "oid"
        case .Tid: return "tid"
        case .Xid: return "xid"
        case .Cid: return "cid"
        case .OidVector: return "oidvector"
        case .PgDdlCommand: return "pg_ddl_command"
        case .PgType: return "pg_type"
        case .PgAttribute: return "pg_attribute"
        case .PgProc: return "pg_proc"
        case .PgClass: return "pg_class"
        case .Json: return "json"
        case .Xml: return "xml"
        case .XmlArray: return "_xml"
        case .PgNodeTree: return "pg_node_tree"
        case .JsonArray: return "_json"
        case .Smgr: return "smgr"
        case .Point: return "point"
        case .Lseg: return "lseg"
        case .Path: return "path"
        case .Box: return "box"
        case .Polygon: return "polygon"
        case .Line: return "line"
        case .LineArray: return "_line"
        case .Cidr: return "cidr"
        case .CidrArray: return "_cidr"
        case .Float4: return "float4"
        case .Float8: return "float8"
        case .Abstime: return "abstime"
        case .Reltime: return "reltime"
        case .Tinterval: return "tinterval"
        case .Unknown: return "unknown"
        case .Circle: return "circle"
        case .CircleArray: return "_circle"
        case .Money: return "money"
        case .MoneyArray: return "_money"
        case .Macaddr: return "macaddr"
        case .Inet: return "inet"
        case .BoolArray: return "_bool"
        case .ByteaArray: return "_bytea"
        case .CharArray: return "_char"
        case .NameArray: return "_name"
        case .Int2Array: return "_int2"
        case .Int2VectorArray: return "_int2vector"
        case .Int4Array: return "_int4"
        case .RegprocArray: return "_regproc"
        case .TextArray: return "_text"
        case .TidArray: return "_tid"
        case .XidArray: return "_xid"
        case .CidArray: return "_cid"
        case .OidVectorArray: return "_oidvector"
        case .BpcharArray: return "_bpchar"
        case .VarcharArray: return "_varchar"
        case .Int8Array: return "_int8"
        case .PointArray: return "_point"
        case .LsegArray: return "_lseg"
        case .PathArray: return "_path"
        case .BoxArray: return "_box"
        case .Float4Array: return "_float4"
        case .Float8Array: return "_float8"
        case .AbstimeArray: return "_abstime"
        case .ReltimeArray: return "_reltime"
        case .TintervalArray: return "_tinterval"
        case .PolygonArray: return "_polygon"
        case .OidArray: return "_oid"
        case .Aclitem: return "aclitem"
        case .AclitemArray: return "_aclitem"
        case .MacaddrArray: return "_macaddr"
        case .InetArray: return "_inet"
        case .Bpchar: return "bpchar"
        case .Varchar: return "varchar"
        case .Date: return "date"
        case .Time: return "time"
        case .Timestamp: return "timestamp"
        case .TimestampArray: return "_timestamp"
        case .DateArray: return "_date"
        case .TimeArray: return "_time"
        case .TimestampTZ: return "timestamptz"
        case .TimestampTZArray: return "_timestamptz"
        case .Interval: return "interval"
        case .IntervalArray: return "_interval"
        case .NumericArray: return "_numeric"
        case .CstringArray: return "_cstring"
        case .Timetz: return "timetz"
        case .TimetzArray: return "_timetz"
        case .Bit: return "bit"
        case .BitArray: return "_bit"
        case .Varbit: return "varbit"
        case .VarbitArray: return "_varbit"
        case .Numeric: return "numeric"
        case .Refcursor: return "refcursor"
        case .RefcursorArray: return "_refcursor"
        case .Regprocedure: return "regprocedure"
        case .Regoper: return "regoper"
        case .Regoperator: return "regoperator"
        case .Regclass: return "regclass"
        case .Regtype: return "regtype"
        case .RegprocedureArray: return "_regprocedure"
        case .RegoperArray: return "_regoper"
        case .RegoperatorArray: return "_regoperator"
        case .RegclassArray: return "_regclass"
        case .RegtypeArray: return "_regtype"
        case .Record: return "record"
        case .Cstring: return "cstring"
        case .Any: return "any"
        case .AnyArray: return "anyarray"
        case .Void: return "void"
        case .Trigger: return "trigger"
        case .LanguageHandler: return "language_handler"
        case .Internal: return "internal"
        case .Opaque: return "opaque"
        case .Anyelement: return "anyelement"
        case .RecordArray: return "_record"
        case .Anynonarray: return "anynonarray"
        case .TxidSnapshotArray: return "_txid_snapshot"
        case .Uuid: return "uuid"
        case .UuidArray: return "_uuid"
        case .TxidSnapshot: return "txid_snapshot"
        case .FdwHandler: return "fdw_handler"
        case .PgLsn: return "pg_lsn"
        case .PgLsnArray: return "_pg_lsn"
        case .TsmHandler: return "tsm_handler"
        case .Anyenum: return "anyenum"
        case .Tsvector: return "tsvector"
        case .Tsquery: return "tsquery"
        case .Gtsvector: return "gtsvector"
        case .TsvectorArray: return "_tsvector"
        case .GtsvectorArray: return "_gtsvector"
        case .TsqueryArray: return "_tsquery"
        case .Regconfig: return "regconfig"
        case .RegconfigArray: return "_regconfig"
        case .Regdictionary: return "regdictionary"
        case .RegdictionaryArray: return "_regdictionary"
        case .Jsonb: return "jsonb"
        case .JsonbArray: return "_jsonb"
        case .Anyrange: return "anyrange"
        case .EventTrigger: return "event_trigger"
        case .Int4Range: return "int4range"
        case .Int4RangeArray: return "_int4range"
        case .NumRange: return "numrange"
        case .NumRangeArray: return "_numrange"
        case .TsRange: return "tsrange"
        case .TsRangeArray: return "_tsrange"
        case .TstzRange: return "tstzrange"
        case .TstzRangeArray: return "_tstzrange"
        case .DateRange: return "daterange"
        case .DateRangeArray: return "_daterange"
        case .Int8Range: return "int8range"
        case .Int8RangeArray: return "_int8range"
        case .Regnamespace: return "regnamespace"
        case .RegnamespaceArray: return "_regnamespace"
        case .Regrole: return "regrole"
        case .RegroleArray: return "_regrole"
        }
    }

    func kind() -> Kind {
        switch self {
        case .Bool: return .Simple
        case .Bytea: return .Simple
        case .Char: return .Simple
        case .Name: return .Simple
        case .Int8: return .Simple
        case .Int2: return .Simple
        case .Int2Vector: return .ArrayInt2
        case .Int4: return .Simple
        case .Regproc: return .Simple
        case .Text: return .Simple
        case .Oid: return .Simple
        case .Tid: return .Simple
        case .Xid: return .Simple
        case .Cid: return .Simple
        case .OidVector: return .ArrayOid
        case .PgDdlCommand: return .Pseudo
        case .PgType: return .Simple
        case .PgAttribute: return .Simple
        case .PgProc: return .Simple
        case .PgClass: return .Simple
        case .Json: return .Simple
        case .Xml: return .Simple
        case .XmlArray: return .ArrayXml
        case .PgNodeTree: return .Simple
        case .JsonArray: return .ArrayJson
        case .Smgr: return .Simple
        case .Point: return .Simple
        case .Lseg: return .Simple
        case .Path: return .Simple
        case .Box: return .Simple
        case .Polygon: return .Simple
        case .Line: return .Simple
        case .LineArray: return .ArrayLine
        case .Cidr: return .Simple
        case .CidrArray: return .ArrayCidr
        case .Float4: return .Simple
        case .Float8: return .Simple
        case .Abstime: return .Simple
        case .Reltime: return .Simple
        case .Tinterval: return .Simple
        case .Unknown: return .Simple
        case .Circle: return .Simple
        case .CircleArray: return .ArrayCircle
        case .Money: return .Simple
        case .MoneyArray: return .ArrayMoney
        case .Macaddr: return .Simple
        case .Inet: return .Simple
        case .BoolArray: return .ArrayBool
        case .ByteaArray: return .ArrayBytea
        case .CharArray: return .ArrayChar
        case .NameArray: return .ArrayName
        case .Int2Array: return .ArrayInt2
        case .Int2VectorArray: return .ArrayInt2Vector
        case .Int4Array: return .ArrayInt4
        case .RegprocArray: return .ArrayRegproc
        case .TextArray: return .ArrayText
        case .TidArray: return .ArrayTid
        case .XidArray: return .ArrayXid
        case .CidArray: return .ArrayCid
        case .OidVectorArray: return .ArrayOidVector
        case .BpcharArray: return .ArrayBpchar
        case .VarcharArray: return .ArrayVarchar
        case .Int8Array: return .ArrayInt8
        case .PointArray: return .ArrayPoint
        case .LsegArray: return .ArrayLseg
        case .PathArray: return .ArrayPath
        case .BoxArray: return .ArrayBox
        case .Float4Array: return .ArrayFloat4
        case .Float8Array: return .ArrayFloat8
        case .AbstimeArray: return .ArrayAbstime
        case .ReltimeArray: return .ArrayReltime
        case .TintervalArray: return .ArrayTinterval
        case .PolygonArray: return .ArrayPolygon
        case .OidArray: return .ArrayOid
        case .Aclitem: return .Simple
        case .AclitemArray: return .ArrayAclitem
        case .MacaddrArray: return .ArrayMacaddr
        case .InetArray: return .ArrayInet
        case .Bpchar: return .Simple
        case .Varchar: return .Simple
        case .Date: return .Simple
        case .Time: return .Simple
        case .Timestamp: return .Simple
        case .TimestampArray: return .ArrayTimestamp
        case .DateArray: return .ArrayDate
        case .TimeArray: return .ArrayTime
        case .TimestampTZ: return .Simple
        case .TimestampTZArray: return .ArrayTimestampTZ
        case .Interval: return .Simple
        case .IntervalArray: return .ArrayInterval
        case .NumericArray: return .ArrayNumeric
        case .CstringArray: return .ArrayCstring
        case .Timetz: return .Simple
        case .TimetzArray: return .ArrayTimetz
        case .Bit: return .Simple
        case .BitArray: return .ArrayBit
        case .Varbit: return .Simple
        case .VarbitArray: return .ArrayVarbit
        case .Numeric: return .Simple
        case .Refcursor: return .Simple
        case .RefcursorArray: return .ArrayRefcursor
        case .Regprocedure: return .Simple
        case .Regoper: return .Simple
        case .Regoperator: return .Simple
        case .Regclass: return .Simple
        case .Regtype: return .Simple
        case .RegprocedureArray: return .ArrayRegprocedure
        case .RegoperArray: return .ArrayRegoper
        case .RegoperatorArray: return .ArrayRegoperator
        case .RegclassArray: return .ArrayRegclass
        case .RegtypeArray: return .ArrayRegtype
        case .Record: return .Pseudo
        case .Cstring: return .Pseudo
        case .Any: return .Pseudo
        case .AnyArray: return .Pseudo
        case .Void: return .Pseudo
        case .Trigger: return .Pseudo
        case .LanguageHandler: return .Pseudo
        case .Internal: return .Pseudo
        case .Opaque: return .Pseudo
        case .Anyelement: return .Pseudo
        case .RecordArray: return .Pseudo
        case .Anynonarray: return .Pseudo
        case .TxidSnapshotArray: return .ArrayTxidSnapshot
        case .Uuid: return .Simple
        case .UuidArray: return .ArrayUuid
        case .TxidSnapshot: return .Simple
        case .FdwHandler: return .Pseudo
        case .PgLsn: return .Simple
        case .PgLsnArray: return .ArrayPgLsn
        case .TsmHandler: return .Pseudo
        case .Anyenum: return .Pseudo
        case .Tsvector: return .Simple
        case .Tsquery: return .Simple
        case .Gtsvector: return .Simple
        case .TsvectorArray: return .ArrayTsvector
        case .GtsvectorArray: return .ArrayGtsvector
        case .TsqueryArray: return .ArrayTsquery
        case .Regconfig: return .Simple
        case .RegconfigArray: return .ArrayRegconfig
        case .Regdictionary: return .Simple
        case .RegdictionaryArray: return .ArrayRegdictionary
        case .Jsonb: return .Simple
        case .JsonbArray: return .ArrayJsonb
        case .Anyrange: return .Pseudo
        case .EventTrigger: return .Pseudo
        case .Int4Range: return .RangeInt4
        case .Int4RangeArray: return .ArrayInt4Range
        case .NumRange: return .RangeNumeric
        case .NumRangeArray: return .ArrayNumRange
        case .TsRange: return .RangeTimestamp
        case .TsRangeArray: return .ArrayTsRange
        case .TstzRange: return .RangeTimestampTZ
        case .TstzRangeArray: return .ArrayTstzRange
        case .DateRange: return .RangeDate
        case .DateRangeArray: return .ArrayDateRange
        case .Int8Range: return .RangeInt8
        case .Int8RangeArray: return .ArrayInt8Range
        case .Regnamespace: return .Simple
        case .RegnamespaceArray: return .ArrayRegnamespace
        case .Regrole: return .Simple
        case .RegroleArray: return .ArrayRegrole
        }
    }

    func swiftType() -> Swift.Any {
        switch self {
        case .Bool: return Swift.Bool
//        case .Bytea: return .Simple
        case .Char: return Swift.String
//        case .Name: return .Simple
        case .Int8: return Swift.Int8
        case .Int2: return Swift.Integer
        case .Int2Vector: return [Swift.Integer]
        case .Int4: return Swift.Integer
//        case .Regproc: return .Simple
        case .Text: return Swift.String
        case .Oid: return Swift.Int16
        case .Tid: return Swift.Int16
        case .Xid: return Swift.Int16
        case .Cid: return Swift.Int16
        case .OidVector: return [Swift.Int16]
//        case .PgDdlCommand: return .Pseudo
//        case .PgType: return .Simple
//        case .PgAttribute: return .Simple
//        case .PgProc: return .Simple
//        case .PgClass: return .Simple
//        case .Json: return .Simple
//        case .Xml: return .Simple
//        case .XmlArray: return .ArrayXml
//        case .PgNodeTree: return .Simple
//        case .JsonArray: return .ArrayJson
//        case .Smgr: return .Simple
//        case .Point: return .Simple
//        case .Lseg: return .Simple
//        case .Path: return .Simple
//        case .Box: return .Simple
//        case .Polygon: return .Simple
//        case .Line: return .Simple
//        case .LineArray: return .ArrayLine
//        case .Cidr: return .Simple
//        case .CidrArray: return .ArrayCidr
        case .Float4: return Swift.Float
        case .Float8: return Swift.Float
//        case .Abstime: return .Simple
//        case .Reltime: return .Simple
//        case .Tinterval: return .Simple
//        case .Unknown: return .Simple
//        case .Circle: return .Simple
//        case .CircleArray: return .ArrayCircle
//        case .Money: return .Simple
//        case .MoneyArray: return .ArrayMoney
//        case .Macaddr: return .Simple
//        case .Inet: return .Simple
        case .BoolArray: return [Swift.Bool]
//        case .ByteaArray: return .ArrayBytea
        case .CharArray: return [Swift.String]
//        case .NameArray: return .ArrayName
        case .Int2Array: return [Swift.Integer]
//        case .Int2VectorArray: return .ArrayInt2Vector
        case .Int4Array: return [Swift.Integer]
//        case .RegprocArray: return .ArrayRegproc
        case .TextArray: return [Swift.String]
//        case .TidArray: return .ArrayTid
//        case .XidArray: return .ArrayXid
//        case .CidArray: return .ArrayCid
//        case .OidVectorArray: return .ArrayOidVector
//        case .BpcharArray: return .ArrayBpchar
        case .VarcharArray: return [Swift.String]
        case .Int8Array: return [Swift.Int8]
//        case .PointArray: return .ArrayPoint
//        case .LsegArray: return .ArrayLseg
//        case .PathArray: return .ArrayPath
//        case .BoxArray: return .ArrayBox
//        case .Float4Array: return .ArrayFloat4
//        case .Float8Array: return .ArrayFloat8
//        case .AbstimeArray: return .ArrayAbstime
//        case .ReltimeArray: return .ArrayReltime
//        case .TintervalArray: return .ArrayTinterval
//        case .PolygonArray: return .ArrayPolygon
//        case .OidArray: return .ArrayOid
//        case .Aclitem: return .Simple
//        case .AclitemArray: return .ArrayAclitem
//        case .MacaddrArray: return .ArrayMacaddr
//        case .InetArray: return .ArrayInet
//        case .Bpchar: return .Simple
//        case .Varchar: return .Simple
//        case .Date: return .Simple
//        case .Time: return .Simple
//        case .Timestamp: return .Simple
//        case .TimestampArray: return .ArrayTimestamp
//        case .DateArray: return .ArrayDate
//        case .TimeArray: return .ArrayTime
//        case .TimestampTZ: return .Simple
//        case .TimestampTZArray: return .ArrayTimestampTZ
//        case .Interval: return .Simple
//        case .IntervalArray: return .ArrayInterval
//        case .NumericArray: return .ArrayNumeric
//        case .CstringArray: return .ArrayCstring
//        case .Timetz: return .Simple
//        case .TimetzArray: return .ArrayTimetz
//        case .Bit: return .Simple
//        case .BitArray: return .ArrayBit
//        case .Varbit: return .Simple
//        case .VarbitArray: return .ArrayVarbit
//        case .Numeric: return .Simple
//        case .Refcursor: return .Simple
//        case .RefcursorArray: return .ArrayRefcursor
//        case .Regprocedure: return .Simple
//        case .Regoper: return .Simple
//        case .Regoperator: return .Simple
//        case .Regclass: return .Simple
//        case .Regtype: return .Simple
//        case .RegprocedureArray: return .ArrayRegprocedure
//        case .RegoperArray: return .ArrayRegoper
//        case .RegoperatorArray: return .ArrayRegoperator
//        case .RegclassArray: return .ArrayRegclass
//        case .RegtypeArray: return .ArrayRegtype
//        case .Record: return .Pseudo
//        case .Cstring: return .Pseudo
//        case .Any: return .Pseudo
//        case .AnyArray: return .Pseudo
//        case .Void: return .Pseudo
//        case .Trigger: return .Pseudo
//        case .LanguageHandler: return .Pseudo
//        case .Internal: return .Pseudo
//        case .Opaque: return .Pseudo
//        case .Anyelement: return .Pseudo
//        case .RecordArray: return .Pseudo
//        case .Anynonarray: return .Pseudo
//        case .TxidSnapshotArray: return .ArrayTxidSnapshot
//        case .Uuid: return .Simple
//        case .UuidArray: return .ArrayUuid
//        case .TxidSnapshot: return .Simple
//        case .FdwHandler: return .Pseudo
//        case .PgLsn: return .Simple
//        case .PgLsnArray: return .ArrayPgLsn
//        case .TsmHandler: return .Pseudo
//        case .Anyenum: return .Pseudo
//        case .Tsvector: return .Simple
//        case .Tsquery: return .Simple
//        case .Gtsvector: return .Simple
//        case .TsvectorArray: return .ArrayTsvector
//        case .GtsvectorArray: return .ArrayGtsvector
//        case .TsqueryArray: return .ArrayTsquery
//        case .Regconfig: return .Simple
//        case .RegconfigArray: return .ArrayRegconfig
//        case .Regdictionary: return .Simple
//        case .RegdictionaryArray: return .ArrayRegdictionary
//        case .Jsonb: return .Simple
//        case .JsonbArray: return .ArrayJsonb
//        case .Anyrange: return .Pseudo
//        case .EventTrigger: return .Pseudo
//        case .Int4Range: return .RangeInt4
//        case .Int4RangeArray: return .ArrayInt4Range
//        case .NumRange: return .RangeNumeric
//        case .NumRangeArray: return .ArrayNumRange
//        case .TsRange: return .RangeTimestamp
//        case .TsRangeArray: return .ArrayTsRange
//        case .TstzRange: return .RangeTimestampTZ
//        case .TstzRangeArray: return .ArrayTstzRange
//        case .DateRange: return .RangeDate
//        case .DateRangeArray: return .ArrayDateRange
//        case .Int8Range: return .RangeInt8
//        case .Int8RangeArray: return .ArrayInt8Range
//        case .Regnamespace: return .Simple
//        case .RegnamespaceArray: return .ArrayRegnamespace
//        case .Regrole: return .Simple
//        case .RegroleArray: return .ArrayRegrole
        default: return Swift.Any
        }
    }
}
