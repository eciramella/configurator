package com.configurator.utils;

import com.netflix.astyanax.AstyanaxContext;
import com.netflix.astyanax.Keyspace;
import com.netflix.astyanax.connectionpool.NodeDiscoveryType;
import com.netflix.astyanax.connectionpool.impl.ConnectionPoolConfigurationImpl;
import com.netflix.astyanax.connectionpool.impl.CountingConnectionPoolMonitor;
import com.netflix.astyanax.impl.AstyanaxConfigurationImpl;
import com.netflix.astyanax.model.ColumnFamily;
import com.netflix.astyanax.model.ColumnList;
import com.netflix.astyanax.model.Row;
import com.netflix.astyanax.serializers.StringSerializer;
import com.netflix.astyanax.thrift.ThriftFamilyFactory;

import java.nio.ByteBuffer;

/**
 * Created with IntelliJ IDEA.
 * User: eciramella
 * Date: 9/18/12
 * Time: 3:16 PM
 * To change this template use File | Settings | File Templates.
 */
public class PropertyListingBean
{
    public ColumnFamily<String, String> getColumnFamily()
    {
        ColumnFamily<String, String> CF_USER_INFO =
            new ColumnFamily<String, String>(
                    "NAMES",              // Column Family Name
                    StringSerializer.get(),   // Key Serializer
                    StringSerializer.get());
             return CF_USER_INFO;
    }
    public Keyspace getKeyspace()
    {
        AstyanaxContext<Keyspace> context = new AstyanaxContext.Builder()
                .forCluster("Test Cluster")
                .forKeyspace("DEMO")
                .withAstyanaxConfiguration(new AstyanaxConfigurationImpl()
                        .setDiscoveryType(NodeDiscoveryType.NONE)
                )
                .withConnectionPoolConfiguration(new ConnectionPoolConfigurationImpl("MyConnectionPool")
                        .setPort(9160)
                        .setMaxConnsPerHost(1)
                        .setSeeds("127.0.0.1:9160")
                )
                .withConnectionPoolMonitor(new CountingConnectionPoolMonitor())
                .buildKeyspace(ThriftFamilyFactory.getInstance());

        context.start();
        return context.getEntity();
    }
    public void runsomething()
    {

    }

}
