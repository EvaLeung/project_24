package com.EvaL.dao;

import com.EvaL.bean.Stock_report;
import com.EvaL.bean.Stock_reportExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface Stock_reportMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    long countByExample(Stock_reportExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    int deleteByExample(Stock_reportExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    int deleteByPrimaryKey(Integer itemId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    int insert(Stock_report record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    int insertSelective(Stock_report record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    List<Stock_report> selectByExample(Stock_reportExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    Stock_report selectByPrimaryKey(Integer itemId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    int updateByExampleSelective(@Param("record") Stock_report record, @Param("example") Stock_reportExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    int updateByExample(@Param("record") Stock_report record, @Param("example") Stock_reportExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    int updateByPrimaryKeySelective(Stock_report record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table stock_report
     *
     * @mbg.generated Wed Dec 04 17:30:43 CST 2019
     */
    int updateByPrimaryKey(Stock_report record);
}