package com.example.coboldemo

// In companion object:

class AnswerToLife {
    companion object {
        init {
            System.loadLibrary("answer")
        }
    }

    external fun cobAnswerToLife(): Int

    fun getAnswerToLife(): Int {
        return cobAnswerToLife()
    }
}