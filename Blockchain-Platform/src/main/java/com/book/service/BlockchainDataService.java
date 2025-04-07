package com.book.service;

import com.book.dao.BlockchainDataDao;
import com.book.domain.BlockchainDataEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class BlockchainDataService {

    private final BlockchainDataDao blockchainDataDao;

    @Autowired
    public BlockchainDataService(BlockchainDataDao blockchainDataDao) {
        this.blockchainDataDao = blockchainDataDao;
    }

    // 获取图表数据
    public List<Object> getChartData(
            String cryptocurrency, 
            String metric, 
            String analysisType
    ) {
        List<BlockchainDataEntity> entities = blockchainDataDao.findByCriteria(
            cryptocurrency, metric, analysisType
        );

        // 转换为前端可用的格式
        return entities.stream()
            .map(entity -> {
                return new Object() {
                    public double x = entity.getxValue();
                    public double y = entity.getyValue();
                };
            })
            .collect(Collectors.toList());
    }

    // 批量插入数据
    @Transactional
    public void saveBlockchainData(List<BlockchainDataEntity> dataList) {
        for (BlockchainDataEntity data : dataList) {
            blockchainDataDao.insertData(data);
        }
    }
}