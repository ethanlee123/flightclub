class RemoveLastWord {
    static String removeLastWord(String str) {
        var splitString = str.split(" ");
        splitString.removeRange(splitString.length - 1, splitString.length);
        var joinedString = splitString.join(" ");
        String removedComma = joinedString.substring(0, joinedString.length - 1);
        return removedComma;
    }
}
