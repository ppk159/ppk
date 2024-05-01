package Entity;

public class student {
	Integer stu_id;
	Integer stu_no;
    String stu_name;
    Integer class_id;
    public student(Integer id,String sname ,Integer sno, Integer sdept) {
    	this.stu_id=id;
        this.stu_no = sno;
        this.stu_name = sname;
        this.class_id = sdept;
    }
    public Integer getstu_id() {
        return stu_id;
    }

    public void setstu_id(Integer stu_id) {
        this.stu_id = stu_id;
    }
    public Integer getstu_no() {
        return stu_no;
    }

    public void setstu_no(Integer stu_no) {
        this.stu_no = stu_no;
    }

    public String getstu_name() {
        return stu_name;
    }

    public void setstu_name(String stu_name) {
        this.stu_name = stu_name;
    }


    public Integer getclass_id() {
        return class_id;
    }

    public void setclass_id(Integer class_id) {
        this.class_id = class_id;
    }
    
}
