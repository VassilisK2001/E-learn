package elearn_classes;

import java.time.LocalDateTime;


public class Message {

    private int messageId;
    private Integer replyToMessageId; // ID of the original message, null if not a reply
    private boolean isRead;
    private boolean isReplied;
    private String senderType;
    private int senderId;
    private int recipientId;
    private LocalDateTime messageDate;
    private String messageSubject;
    private String messageContent;

    // Constructor
    public Message(int messageId, Integer replyToMessageId, boolean isRead ,boolean isReplied, String senderType, int senderId, 
                   int recipientId, LocalDateTime messageDate, String messageSubject, String messageContent) {
        this.messageId = messageId;
        this.replyToMessageId = replyToMessageId;
        this.isRead = isRead;
        this.isReplied = isReplied;
        this.senderType = senderType;
        this.senderId = senderId;
        this.recipientId = recipientId;
        this.messageDate = messageDate;
        this.messageSubject = messageSubject;
        this.messageContent = messageContent;
    }

    // Default Constructor
    public Message(){}

    // Getters and Setters
    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public Integer getReplyToMessageId() {
        return replyToMessageId;
    }

    public void setReplyToMessageId(Integer replyToMessageId) {
        this.replyToMessageId = replyToMessageId;
    }

    public boolean isReplied() {
        return isReplied;
    }

    public void setReplied(boolean replied) {
        isReplied = replied;
    }

    public String getSenderType() {
        return senderType;
    }

    public void setSenderType(String senderType) {
        if (!"teacher".equalsIgnoreCase(senderType) && !"student".equalsIgnoreCase(senderType)) {
            throw new IllegalArgumentException("Invalid sender type: " + senderType);
        }
        this.senderType = senderType;
    }

    public int getSenderId() {
        return senderId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }

    public int getRecipientId() {
        return recipientId;
    }

    public void setRecipientId(int recipientId) {
        this.recipientId = recipientId;
    }

    public LocalDateTime getMessageDate() {
        return messageDate;
    }

    public void setMessageDate(LocalDateTime messageDate) {
        this.messageDate = messageDate;
    }

    public String getMessageSubject() {
        return messageSubject;
    }

    public void setMessageSubject(String messageSubject) {
        this.messageSubject = messageSubject;
    }

    public String getMessageContent() {
        return messageContent;
    }

    public void setMessageContent(String messageContent) {
        this.messageContent = messageContent;
    }

    public boolean getIsRead() {
        return isRead;
    }

    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }
}
