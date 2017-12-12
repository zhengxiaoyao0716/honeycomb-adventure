import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import styles from './Hello.css';

const Hello = ({ text }) => (<div className={styles.Hello}>{text}</div>);
Hello.propTypes = {
    text: PropTypes.string.isRequired,
};
Hello.contextTypes = {
    store: PropTypes.object.isRequired,
};

export default connect(({ hello: { text } }) => ({ text }))(Hello);
