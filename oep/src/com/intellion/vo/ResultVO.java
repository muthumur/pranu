package com.intellion.vo;

public class ResultVO {
	
	public String examId;
	public String quesId;
	public String userName;
	public String userAnswer;
	public String correctAnswer;
	public String isAnsCorrect;
	public String quesDesc;
	public String examName;
	
	public String getQuesDesc() {
		return quesDesc;
	}
	public void setQuesDesc(String quesDesc) {
		this.quesDesc = quesDesc;
	}
	public String getExamName() {
		return examName;
	}
	public void setExamName(String examName) {
		this.examName = examName;
	}
	public String getExamId() {
		return examId;
	}
	public void setExamId(String examId) {
		this.examId = examId;
	}
	public String getQuesId() {
		return quesId;
	}
	public void setQuesId(String quesId) {
		this.quesId = quesId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserAnswer() {
		return userAnswer;
	}
	public void setUserAnswer(String userAnswer) {
		this.userAnswer = userAnswer;
	}
	public String getCorrectAnswer() {
		return correctAnswer;
	}
	public void setCorrectAnswer(String correctAnswer) {
		this.correctAnswer = correctAnswer;
	}
	public String getIsAnsCorrect() {
		return isAnsCorrect;
	}
	public void setIsAnsCorrect(String isAnsCorrect) {
		this.isAnsCorrect = isAnsCorrect;
	}

}
