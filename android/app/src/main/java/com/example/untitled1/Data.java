package com.example.untitled1;

import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;


public class Data implements Parcelable {
    public static final Creator<Data> CREATOR = new Creator<Data>() {
        public Data createFromParcel(Parcel parcel) {
            return new Data(parcel);
        }

        public Data[] newArray(int i) {
            return new Data[i];
        }
    };
    private String englishName = "";
    private String name = "";
    private String englishNameUnderscored = "";
    private int id = 0;
    private int index = 0;
    private int imageHeight = 0;
    private String imageUrl = "";
    private int imageWidth = 0;
    private String latinName = "";
    private String latinNameUnderscored = "";
    private float percentageAccuracy = 0;
    private String wikipediaUrl = "";
    private int type = -1;
    private String extract ="";

    public int describeContents() {
        return 0;
    }

    public Data() {
    }

    public Data(String text, int index, float confidence) {
        this.percentageAccuracy = confidence;
        String[] split = text.split("\\(");
        if (split.length == 2) {
            this.latinName = split[0].trim();
            this.latinNameUnderscored = this.latinName.replaceAll("\\s", "_");
            this.englishName = split[1].replaceAll("\\)", "").trim();
            this.englishNameUnderscored = this.englishName.replaceAll("\\s", "_");
        }
        if (split.length == 1) {
            this.latinName = split[0].trim();
            this.latinNameUnderscored = this.latinName.replaceAll("\\s", "_");
        }
        if (split.length <= 2) {
            this.index = index;
            if (!this.englishNameUnderscored.isEmpty()) {
                this.englishNameUnderscored = toProperCase(this.englishNameUnderscored);
                this.wikipediaUrl = "https://en.wikipedia.org/wiki/" + this.englishNameUnderscored;
                return;
            }
            this.wikipediaUrl = "https://en.wikipedia.org/wiki/" + this.latinNameUnderscored;
        }
    }
    public  String toProperCase(String str) {
        if (str == null || str.length() <= 1) {
            return "";
        }
        String upperCase = str.substring(0, 1).toUpperCase();
        return upperCase + str.substring(1).toLowerCase();
    }
    public void setEnglishName(String englishName) {
        this.englishName = englishName;
    }

    public void setEnglishNameUnderscored(String englishNameUnderscored) {
        this.englishNameUnderscored = englishNameUnderscored;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public void setLatinName(String latinName) {
        this.latinName = latinName;
    }

    public void setLatinNameUnderscored(String latinNameUnderscored) {
        this.latinNameUnderscored = latinNameUnderscored;
    }

    public void setPercentageAccuracy(float percentageAccuracy) {
        this.percentageAccuracy = percentageAccuracy;
    }

    public String getExtract() {
        return extract;
    }

    public void setExtract(String extract) {
        this.extract = extract;
    }

    public void setWikipediaUrl(String wikipediaUrl) {
        this.wikipediaUrl = wikipediaUrl;
    }

    public String getWikiName() {
        return TextUtils.isEmpty(englishName)? latinName: englishName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setImageUrl(String str) {
        this.imageUrl = str;
    }

    public String getEnglishName() {
        return this.englishName;
    }

    public String getLatinName() {
        return this.latinName;
    }

    public int getId() {
        return this.id;
    }

    public float getPercentageAccuracy() {
        return this.percentageAccuracy;
    }

    public String getWikipediaUrl() {
        return this.wikipediaUrl;
    }

    public String getImageUrl() {
        return this.imageUrl;
    }

    public String getEnglishNameUnderscored() {
        return this.englishNameUnderscored;
    }

    public String getLatinNameUnderscored() {
        return this.latinNameUnderscored;
    }

    public void setImageHeight(int i) {
        this.imageHeight = i;
    }

    public void setImageWidth(int i) {
        this.imageWidth = i;
    }

    public int getImageHeight() {
        return this.imageHeight;
    }

    public int getImageWidth() {
        return this.imageWidth;
    }

    protected Data(Parcel parcel) {
        this.englishName = parcel.readString();
        this.latinName = parcel.readString();
        this.englishNameUnderscored = parcel.readString();
        this.latinNameUnderscored = parcel.readString();
        this.id = parcel.readInt();
        this.percentageAccuracy = parcel.readFloat();
        this.wikipediaUrl = parcel.readString();
        this.imageUrl = parcel.readString();
        this.imageHeight = parcel.readInt();
        this.imageWidth = parcel.readInt();
        this.extract = parcel.readString();
    }

    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(this.englishName);
        parcel.writeString(this.latinName);
        parcel.writeString(this.englishNameUnderscored);
        parcel.writeString(this.latinNameUnderscored);
        parcel.writeInt(this.id);
        parcel.writeFloat(this.percentageAccuracy);
        parcel.writeString(this.wikipediaUrl);
        parcel.writeString(this.imageUrl);
        parcel.writeInt(this.imageHeight);
        parcel.writeInt(this.imageWidth);
        parcel.writeString(this.extract);
    }
}
