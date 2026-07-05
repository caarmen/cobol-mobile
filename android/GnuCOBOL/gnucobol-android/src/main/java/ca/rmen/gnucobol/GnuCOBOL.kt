package ca.rmen.gnucobol

object GnuCOBOL {
    fun initialize() {
        System.loadLibrary("cob")
        System.loadLibrary("cobjni")
        cobInit();
    }

    external fun cobInit()
}