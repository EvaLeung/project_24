package com.EvaL.dao;

import com.EvaL.bean.Sell_report;
import com.EvaL.bean.Sell_reportExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface Sell_reportMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    long countByExample(Sell_reportExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    int deleteByExample(Sell_reportExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    int deleteByPrimaryKey(Integer itemId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    int insert(Sell_report record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    int insertSelective(Sell_report record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    List<Sell_report> selectByExample(Sell_reportExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    Sell_report selectByPrimaryKey(Integer itemId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    int updateByExampleSelective(@Param("record") Sell_report record, @Param("example") Sell_reportExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    int updateByExample(@Param("record") Sell_report record, @Param("example") Sell_reportExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    int updateByPrimaryKeySelective(Sell_report record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table sell_report
     *
     * @mbg.generated Sat Dec 07 17:19:42 CST 2019
     */
    int updateByPrimaryKey(Sell_report record);
}