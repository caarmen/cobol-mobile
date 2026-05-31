package com.example.coboldemo

// In companion object:

class AnswerToLife {
    companion object {
        init {
            System.loadLibrary("answer")
        }
    }
    external fun cobAnswerToLife(): String

    fun getAnswerToLife(): String {
        return cobAnswerToLife()
    }
}