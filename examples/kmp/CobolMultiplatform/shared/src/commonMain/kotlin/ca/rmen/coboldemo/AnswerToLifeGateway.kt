package ca.rmen.coboldemo

interface AnswerToLifeGateway {
    fun getAnswerToLife(): Int
}

expect fun AnswerToLifeGateway(): AnswerToLifeGateway
