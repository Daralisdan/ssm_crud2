package com.daralisdan.dao;

import com.daralisdan.bean.Deparment;
import com.daralisdan.bean.DeparmentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DeparmentMapper {
    long countByExample(DeparmentExample example);

    int deleteByExample(DeparmentExample example);

    int insert(Deparment record);

    int insertSelective(Deparment record);

    List<Deparment> selectByExample(DeparmentExample example);

    int updateByExampleSelective(@Param("record") Deparment record, @Param("example") DeparmentExample example);

    int updateByExample(@Param("record") Deparment record, @Param("example") DeparmentExample example);
}