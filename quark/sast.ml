module A = Ast
module T = Type

(* tag what operator is actually used in C++ *)
type op_tag = 
  | OpVerbatim  (* no change to the operator *)
  | CastComplex1 (* cast the first arg to complex *)
  | CastComplex2 (* cast the second arg to complex *)
  | CastFraction1 (* cast the first arg to fraction *)
  | CastFraction2 (* cast the second arg to fraction *)
  | OpFloatComparison (* equality/inequality with tolerance *)
  | OpArrayConcat
  | OpStringConcat
  | OpMatrixKronecker
  | OpMatrixTranspose
  | OpQuerySingleBit (* measure only a single bit, not a range *)

type lvalue =
  | Variable of string
  | ArrayElem of string * expr list
  | MatrixElem of string * expr list

and expr =
  | Binop of expr * A.binop * expr * op_tag
  | Queryop of expr * A.queryop * expr * expr * op_tag (* QuerySingleBit *)
  | Unop of A.unop * expr * op_tag
  | PostOp of lvalue * A.postop
  | Assign of lvalue * expr
  | IntLit of string
  | BoolLit of string
  | FloatLit of string
  | StringLit of string
  | FractionLit of expr * expr
  | QRegLit of expr * expr
  | ComplexLit of expr * expr
  | ArrayLit of A.datatype * expr list
  | ArrayCtor of A.datatype * expr (* int size of new array *)
  | MatrixLit of A.datatype * expr list * int (* column dimension. Flattened *)
  | MatrixCtor of A.datatype * expr * expr (* int, int of new Matrix::Zeros() *)
  | FunctionCall of string * expr list * bool list (* is_matrix, for pretty print *)
  | Lval of lvalue
  | Membership of expr * expr
  | Tertiary of expr * expr * expr * op_tag

type decl =
  | AssigningDecl of A.datatype * string * expr
  | PrimitiveDecl of A.datatype * string

type range = Range of A.datatype * expr * expr * expr

type iterator =
    (* first datatype in RangeIterator might be NoneType *)
  | RangeIterator of A.datatype * string * range 
  | ArrayIterator of A.datatype * string * expr

type statement =
  | CompoundStatement of statement list
  | Declaration of decl
  | Expression of expr
  | EmptyStatement
  | IfStatement of expr * statement * statement
  | WhileStatement of expr * statement
  | ForStatement of iterator * statement
  | FunctionDecl of A.datatype * string * decl list * statement list
  | ForwardDecl of A.datatype * string * decl list
  | ReturnStatement of expr
  | VoidReturnStatement
  | BreakStatement
  | ContinueStatement
