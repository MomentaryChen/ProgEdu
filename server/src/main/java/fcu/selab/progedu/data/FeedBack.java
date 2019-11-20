package fcu.selab.progedu.data;

import fcu.selab.progedu.status.StatusEnum;

public class FeedBack {

  private String status;

  private String line;

  private String message;

  private String symptom;

  private String suggest;

  private final String emptyString = "";

  /**
   * Create new FeedBack class
   *
   * @param status type StatusEnum
   * @param line type occur line
   * @param message type occur message
   * @param symptom type occur symptom
   * @param suggest type giving suggest
   */
  public  FeedBack(StatusEnum status, String line, String message, String symptom, String suggest) {
    this.status = status.getType();
    this.line = line;
    this.message = message;
    this.symptom = symptom;
    this.suggest = suggest;
  }

  /**
   * Create new FeedBack class
   *
   * @param status type StatusEnum
   * @param message type occur message
   */
  public  FeedBack(StatusEnum status, String message) {
    new FeedBack(status, emptyString, message, emptyString, emptyString);
  }

  public String getStatus() {
    return this.status;
  }

  public void setStyle(StatusEnum statusEnum) {
    this.status= statusEnum.getType();
  }

  public String getLine() {
    return this.line;
  }

  public void setLine(String line) {
    this.line = line;
  }

  public String getMessage() {
    return this.message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public String getSymptom() {
    return this.symptom;
  }

  public void setSymptom(String symptom) {
    this.symptom = symptom;
  }

  public String getSuggest() {
    return this.suggest;
  }

  public void setSuggest(String suggest) {
    this.suggest = suggest;
  }

}