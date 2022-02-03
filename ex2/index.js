const antlr4 = require('antlr4/index')
const fs = require('fs')
const ex2Parser = require('./ex2Parser.js')
const ex2Lexer = require('./ex2Lexer.js')

var input = fs.readFileSync('aFile.cs').toString()
var chars = new antlr4.InputStream(input)
var lexer = new ex2Lexer.ex2Lexer(chars)
var tokens = new antlr4.CommonTokenStream(lexer)
var parser = new ex2Parser.ex2Parser(tokens)
var tree = parser.namespace_member_declarations()
var res = []
var ex2Class = new ex2FunctionListener(res)
antlr4.tree.ParseTreeWalker.DEFAULT.walk(ex2Class, tree)
console.log('Function names: ', res.join(','))