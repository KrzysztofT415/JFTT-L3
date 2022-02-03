const antlr4 = require('antlr4/index')
const ex2Lexer = require('./ex2Lexer')
const ex2Parser = require('./ex2Parser')
var ex2Listener = require('./ex2ParserListener').ex2ParserListener
ex2FunctionListener = function (res) {
    this.Res = res
    ex2Listener.call(this) // inherit default listener
    return this
}

// inherit default listener
ex2FunctionListener.prototype = Object.create(ex2Listener.prototype)
ex2FunctionListener.prototype.constructor = ex2FunctionListener
ex2FunctionListener.prototype.enterMethod_member_name = function (ctx) {
    this.Res.push(ctx.getText())
}
exports.ex2FunctionListener = ex2FunctionListener
